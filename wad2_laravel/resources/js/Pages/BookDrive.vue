    <script setup>
    import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
    import Card from '@/Components/Card.vue';
    import { Head, Link } from '@inertiajs/vue3';
    import Modal from '@/Components/Modal.vue';
    import UploadForm from '@/Components/UploadForm.vue';
    import axios from 'axios';
    import GoogleMapLoader from '@/Components/GoogleMapLoader.vue';
    import PrimaryButton from '@/Components/PrimaryButton.vue';
    const BASE_URL = import.meta.env.VITE_APP_URL;
    </script>

    <script>
    //Startup load calls
    export default {
        data() {
            return {
                user_donations: [],
                storeDBlocation:[],
                storeDBlocationJson:[],
                gpsLocationCoordinate:null,
                sourceText:null,
                sourceAutocomplete:null,

                destinationText:null,
                closestDistance:null,

                searchedSourceCoordinates:null,
                destinationCoordinates:null
            }
        },
        methods: {
            getUserDonations() {
                console.log("in getUser")
                axios.get("/api/user/donations")
                    .then(
                        response => {
                            this.user_donations = response.data;
                        }
                    )
            },
            getAndSendDBLocationData(){
                var url ="/api/location/get-Location"
                axios.post(url)
                    .then(result => {
                        
                        console.log(result)
                    
                        this.storeDBlocation = result.data;

                        console.log(this.storeDBlocation); // Contains the parsed data

                        // Using forEach
                        this.storeDBlocation.forEach(item => {
                            const location = item.location;
                            const locationJson = JSON.parse(location);
                            this.storeDBlocationJson.push(locationJson);
                        });
                        console.log(this.storeDBlocationJson)

                        if(this.storeDBlocationJson){
                            this.storeDBlocationJson.forEach((item, index) => {
                                sessionStorage.setItem(`DBlocationJson${index}`, JSON.stringify(item));
                            });
                        }
                        
                    })
                    .catch(err => {
                        console.log('Error: ' + err);
                        throw err;
                    });
            },
            sendSearchedSourceCoordinates(){
                //geocode the source Text to get coord
                const geocoder = new google.maps.Geocoder();
                geocoder.geocode({ 'address': this.sourceText }, (results, status) => {
                if (status === 'OK' && results[0]) {
                    this.searchedSourceCoordinates = {
                        lat: results[0].geometry.location.lat(),
                        lng: results[0].geometry.location.lng()
                    };
                } else {
                    console.error('Geocode was not successful for the destination address.');
                }

                if (this.searchedSourceCoordinates) {
                    sessionStorage.setItem('searchedSourceCoordinate', JSON.stringify(this.searchedSourceCoordinates));
                    console.log(this.searchedSourceCoordinates);
                }
            });


            },
            GetGpsLocationCoordAndSetSourceTextOnLoad(){
                
                if(navigator.geolocation){
                    navigator.geolocation.getCurrentPosition((position)=>{
                        this.gpsLocationCoordinate={
                            lat: position.coords.latitude,
                            lng: position.coords.longitude,
                        }


                        //if obtained GPS LOCATION
                        if(this.gpsLocationCoordinate){
                            //pass on to GoogleMapLoader.Vue if gpsLocation is set
                            sessionStorage.setItem('GpsLocationCoordinate', JSON.stringify(this.gpsLocationCoordinate));
                            console.log(this.gpsLocationCoordinate)


                            //convert coord to text
                            const geocoder = new google.maps.Geocoder();
                            geocoder.geocode({ 'location': this.gpsLocationCoordinate }, (results, status) => {
                                if (status === 'OK' && results[0]) {

                                    // v-model and display to the text box
                                    this.sourceText = results[0].formatted_address; // Set sourceLocation to the formatted address
                                    
                                
                                    console.log(this.sourceText);
                                }

                            });
                            

                        }
                    




                    
                    })
                }

        
            },
            setDestinationTextAndSendDestinationCoord(){
                                //find closest bookstore destination coord
                                this.findNearestBookStore(this.gpsLocationCoordinate);



                                //geocode the destination coordinate

                                //convert coord to text
                                const geocoder2 = new google.maps.Geocoder();
                                geocoder2.geocode({ 'location': this.destinationCoordinates }, (results, status) => {
                                    if (status === 'OK' && results[0]) {

                                        // v-model and display to the text box
                                        this.destinationText = results[0].formatted_address; // Set sourceLocation to the formatted address
                                        
                                        
                                        
                                    }

                                });

                                if(this.destinationCoordinates){
                            //pass on to GoogleMapLoader.Vue if gpsLocation is set
                            sessionStorage.setItem('destinationCoordinate', JSON.stringify(this.destinationCoordinates));
                            console.log(this.destinationCoordinates)
                        }

            },
            
            //math formula to find the shortest distance between two coords
            
            findNearestBookStore(userCoord){
                let nearestBookstoreCoord = null;
                let nearestDistance = Number.MAX_VALUE;

                this.storeDBlocationJson.forEach(dataInside=>{
                    const DBLocationCoord = dataInside.location;
                    this.haverSine(userCoord, DBLocationCoord);

                    if(this.closestDistance <nearestDistance){
                        nearestBookstoreCoord = dataInside.location;
                    }
                })
                this.destinationCoordinates = nearestBookstoreCoord;
              

            },
            haverSine(coord1,coord2){

                const R = 6371; // Earth's radius in km
                const lat1 = coord1.lat;
                const lon1 = coord1.lng;
                const lat2 = coord2.lat;
                const lon2 = coord2.lng;

                const dLat = (lat2 - lat1) * (Math.PI / 180);
                const dLon = (lon2 - lon1) * (Math.PI / 180);

                const a =
                Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                Math.cos(lat1 * (Math.PI / 180)) *
                Math.cos(lat2 * (Math.PI / 180)) *
                Math.sin(dLon / 2) *
                Math.sin(dLon / 2);

                const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

                this.closestDistance = R * c;
                
            },
            autoCompleteSource(){
                this.sourceAutocomplete = new google.maps.places.Autocomplete(
                                document.getElementById('source')
                            );

                            this.sourceAutocomplete.addListener('place_changed', () => {
                                const place = this.sourceAutocomplete.getPlace();
                                if (place && place.formatted_address) {
                                this.sourceText = place.formatted_address; // Set sourceText to the selected place's formatted address
                                }
                            });
            }


        },
        
        beforeMount() {
            this.getUserDonations();
        
        },
        mounted(){
            this.getAndSendDBLocationData();
            this.GetGpsLocationCoordAndSetSourceTextOnLoad();
            


    

    
        }
    };







    </script>


    <template>
        <Head title="Book Catalogue" />
        <AuthenticatedLayout>

            <div class="container bg-white my-5 p-5 rounded-2">

                <div class="form-group">
                        <h2>Source location:</h2>
                        <!--v if to ensure the sourceText get loaded first-->
                        <input  type="text" v-if="GetGpsLocationCoordAndSetSourceTextOnLoad" class="form-control" placeholder="Source Location" id="source" v-model="this.sourceText">
                </div>


                <div class="form-group">
                        <h2>Nearest bookdrive:</h2>
                        <input type="text"  class="form-control" placeholder="Destination Location" id="destination" v-model="this.destinationText">
                </div>


                    <button class="btn btn-primary" @click="setDestinationTextAndSendDestinationCoord" >Get Direction</button>
                    


                <GoogleMapLoader :destinationCoord="destinationCoordinates">

        
            

                </GoogleMapLoader>


            </div>
        
        </AuthenticatedLayout>
    </template>
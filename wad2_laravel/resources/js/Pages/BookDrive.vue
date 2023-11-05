    <script setup>
    import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
    import Card from '@/Components/Card.vue';
    import { Head, Link } from '@inertiajs/vue3';
    import Modal from '@/Components/Modal.vue';
    import UploadForm from '@/Components/UploadForm.vue';
    import axios from 'axios';
    import GoogleMapLoader from '@/Components/GoogleMapLoader.vue';
    import PrimaryButton from '@/Components/PrimaryButton.vue';
    import { ref } from 'vue'
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
                sourceCoordinate:null,
                sourceText:null,
                sourceAutocomplete:null,

                destinationText:'',
                closestDistance:null,

                searchedSourceCoordinates:null,
                destinationCoordinates:null,
                path:null,
                travelMode:"DRIVING"

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
  
            GetGpsLocationCoordAndSetSourceTextOnLoad(){
                
                if(navigator.geolocation){
                    navigator.geolocation.getCurrentPosition((position)=>{
                        this.sourceCoordinate={
                            lat: position.coords.latitude,
                            lng: position.coords.longitude,
                        }


                        //if obtained GPS LOCATION
                        if(this.sourceCoordinate){
                            //pass on to GoogleMapLoader.Vue if gpsLocation is set
                            sessionStorage.setItem('sourceCoordinate', JSON.stringify(this.sourceCoordinate));
                            console.log(this.sourceCoordinate)


                                //convert coord to text
                                const geocoder = new google.maps.Geocoder();
                                geocoder.geocode({ 'location': this.sourceCoordinate }, (results, status) => {
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

                                // onclick button , get new sourceText , convert to coord then pass
                                const geocoder = new google.maps.Geocoder();
                                geocoder.geocode({ 'address': this.sourceText }, (results, status) => {
                                        if (status === 'OK' && results[0]) {
                                        this.sourceCoordinate = {
                                            lat: results[0].geometry.location.lat(),
                                            lng: results[0].geometry.location.lng()
                                        };

                                        } else {
                                        console.error('Geocode was not successful for the destination address.');
                                        }
                                });

                            //console.log(this.sourceCoordinate);
                                        
                           
                            if(this.sourceCoordinate){
                                sessionStorage.setItem('updateSourceCoordinate', JSON.stringify(this.sourceCoordinate));
                                //console.log(this.sourceCoordinate)
                            }
                            
                                


                                //find closest bookstore destination coord
                                this.findNearestBookStore(this.sourceCoordinate);



                                //geocode the destination coordinate

                                //convert coord to text
                                const geocoder2 = new google.maps.Geocoder();
                                geocoder2.geocode({ 'location': this.destinationCoordinates }, (results, status) => {
                                    if (status === 'OK' && results[0]) {
                                        
                                        // v-model and display to the text box
                                        this.destinationText = results[0].formatted_address; // Set destinationLocation to the formatted address
                                        console.log(this.destinationText)
                                        
                                        
                                    }

                                });

                            if(this.destinationCoordinates){
                            //pass on to GoogleMapLoader.Vue if gpsLocation is set
                            sessionStorage.setItem('destinationCoordinate', JSON.stringify(this.destinationCoordinates));
                            console.log(this.destinationCoordinates)
                        }

                        this.$refs.mapChild.getUpdatedSourceCoordAndDestinationCoord();

                        this.calculateAndDisplayRoute(this.sourceCoordinate, this.destinationCoordinates);

            },
            
            //math formula to find the shortest distance between two coords
            
            findNearestBookStore(userCoord){
                
                let nearestBookstoreCoord = null; //store the neearest loc
                let nearestDistance = Number.MAX_VALUE;
                console.log(this.storeDBlocationJson)
                
                this.storeDBlocationJson.forEach(dataInside=>{
                    console.log(userCoord)              //location
                    console.log(dataInside.location)    //nearest location

                    this.haverSine(userCoord, dataInside.location);

                    if(this.closestDistance < nearestDistance){
                        nearestBookstoreCoord = dataInside.location; 
                        nearestDistance = this.closestDistance;
                    }
                    console.log(this.closestDistance) //the distance between location and nearest location
                    console.log(nearestDistance)

                    
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
            },
            updateTravelModeWalking(){

                this.travelMode = 'WALKING'
                if(this.travelMode){
                                sessionStorage.setItem('updateTravelMode', this.travelMode);
                                
                }
                            console.log("Travelmode set to : ", this.travelMode)
            },

            updateTravelModeDriving(){

                this.travelMode = 'DRIVING'
                if(this.travelMode){
                    sessionStorage.setItem('updateTravelMode', this.travelMode);
                                
                }
                console.log("Travelmode set to : ", this.travelMode)

}




        },
        beforeMount() {
            this.getUserDonations();
        
        },
        mounted(){
            this.getAndSendDBLocationData();
            this.GetGpsLocationCoordAndSetSourceTextOnLoad();
            this.autoCompleteSource();

        }
    };




//:destinationCoord="destinationCoordinates"


    </script>


    <template>
        <Head title="Book Catalogue" />
        <AuthenticatedLayout>
            
            <div class="container p-5 bg-white rounded-2" >
                <h1 style="text-align: center;">Closest Book Drive</h1>
                <div class="container" style="display: flex; justify-content: center; align-items: center;">
                    <img src="/bookDrive/bookIcon.gif" style="height: 100px;">
                </div>
                <div class="form-group">
                        <h2 style="color:rgb(213, 116, 116)">Source location:</h2>
                        <!--v if to ensure the sourceText get loaded first-->
                        <input  type="text" class="form-control" placeholder="Source Location" id="source" v-model="this.sourceText" />
                </div>


                <div class="form-group">
                        <h2 style="color:rgb(11, 215, 92)">Nearest bookdrive:</h2>
                        <input type="text"  class="form-control" placeholder="Destination Location" id="destination" v-model="destinationText" />
                        
                </div>
                    <button class="btn btn-success" @click="updateTravelModeDriving()" >DRIVING</button>
                    <button class="btn btn-primary" @click="updateTravelModeWalking()" >WALKING</button>
                    <button class="btn btn-info" @click="setDestinationTextAndSendDestinationCoord()" >Get Direction</button>
                    <h2 style="color:rgb(6, 6, 6)">Travel Mode:</h2>
                    <input  type="text" class="col-1" placeholder="Source Location" id="source" v-model="this.travelMode"  :style="{ color: travelMode === 'WALKING' ? 'red' : 'green' ,'border-radius': '10px'}"/>
                    

                    
                <GoogleMapLoader ref="mapChild" >

        
            

                </GoogleMapLoader>


            </div>
        
        </AuthenticatedLayout>
    </template>




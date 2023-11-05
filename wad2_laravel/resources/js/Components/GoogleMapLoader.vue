<script>



export default {
  // props: {
  //   destinationCoord: Object,
  // },
  data() {
    return {
      userSourceCoordinate:null,
      userDestinationCoordinate:null,
      center: null,
      dbLocationData: [],
      closestDistance:null,
      closestDistanceCoordinate:null,
      searchedSourceCoord:null,
      path: [],
        manualIndex:1,
        manualIndex2:2,
        openedMarkerID1: null,
        openedMarkerID2: null,
        destinationImage:null,
        destinationName:null,
        destinationAddress:null,
        SourceText:null,
        userMarkerIconImagePath:"/bookDrive/location.png",
                destinationMarkerIconImagePath:"/bookDrive/book.png",
                path:null,
                typeOfTravelMode: 'DRIVING',
                directionsRenderer:null,
                directionsService:null
  


    }
  },methods:{
    openMarker1(id) {
       this.openedMarkerID1 = id
    },
    openMarker2(id) {
       this.openedMarkerID2 = id
    },
    getDatabaseLocationData() {
      let index = 0;
      while (true) {
        const key = `DBlocationJson${index}`;
        const storedData = sessionStorage.getItem(key);
        if (storedData) {
          this.dbLocationData.push(JSON.parse(storedData));
          
          index++; // Move on to the next item
        } else {
          break; // Stop when no more data is found
        }
        
      }
    }
,//call this function in BookDrive using REF MAPCHILD
    getUpdatedSourceCoordAndDestinationCoord(){
      console.log("in getUpdated")
      const updatedSourceCoordData = sessionStorage.getItem('updateSourceCoordinate');
            console.log(updatedSourceCoordData)
            
            if(updatedSourceCoordData){
              const updateDataToUse = JSON.parse(updatedSourceCoordData);
              //update userSource COORD to the new text that user typed
              this.userSourceCoordinate = updateDataToUse
      
            } else {
              // Handle the case where the data is not found in sessionStorage
              console.log('No shared data found for source.');
            }




            //convert coord to text
            const geocoder = new google.maps.Geocoder();
            geocoder.geocode({ 'location': this.userSourceCoordinate }, (results, status) => {
                if (status === 'OK' && results[0]) {

                    // v-model and display to the text box
                    this.SourceText = results[0].formatted_address; // Set sourceLocation to the formatted address
                    
                
                    console.log(this.SourceText);
                }

            });

            //update destination coord to the new text that user typed
      const updatedDestinationCoordData = sessionStorage.getItem('destinationCoordinate');

      if(updatedDestinationCoordData){
        const updateDestinationCoordDataToUse = JSON.parse(updatedDestinationCoordData);

        this.userDestinationCoordinate = updateDestinationCoordDataToUse


   

        // get the database location String JSON format data which consist of img , address , name of book drive
        this.dbLocationData.forEach((dataInside) => {
          // Your code here...
          console.log(this.userDestinationCoordinate)
          console.log(dataInside.location);
          console.log('Inside the if block');
          if (this.userDestinationCoordinate.lat == dataInside.location.lat) {
          console.log('Print something')
          this.destinationName = dataInside.name;
          this.destinationImage = dataInside.img;
          this.destinationAddress = dataInside.address;
  
          
          }



        });

        this.getTravelMode();
        this.calculateAndDisplayRoute(this.userSourceCoordinate,this.userDestinationCoordinate);

        
        console.log(this.dbLocationData);
        console.log(this.dbLocationData);
        console.log(this.dbLocationData);
        console.log(this.dbLocationData);
        console.log(this.dbLocationData);


        console.log(this.userDestinationCoordinate)
        console.log(this.userDestinationCoordinate);
        console.log(this.userDestinationCoordinate);
        console.log(this.userDestinationCoordinate);
        console.log(this.userDestinationCoordinate);
        console.log(this.userDestinationCoordinate);
        console.log(this.userDestinationCoordinate);

      }else {
              // Handle the case where the data is not found in sessionStorage
              console.log('No shared data found for destination.');
          }




          console.log(this.destinationName);
          console.log(this.destinationImage);
          console.log(this.destinationAddress);


    },
      getGpsLocationCoord(){
        //get gps coordinate pass from BookDrive.Vue
        const GpsData = sessionStorage.getItem('sourceCoordinate');
            console.log(GpsData)
            
            if(GpsData){
              const GpsDataToUse = JSON.parse(GpsData);
              //update GPS COORD
              this.userSourceCoordinate = GpsDataToUse;

              // Now, GpsDataToUse contains the shared data
              console.log(GpsDataToUse);
            } else {
              // Handle the case where the data is not found in sessionStorage
              console.log('No shared data found.');
            }

            //convert coord to text
            const geocoder = new google.maps.Geocoder();
            geocoder.geocode({ 'location': this.userSourceCoordinate }, (results, status) => {
                if (status === 'OK' && results[0]) {

                    // v-model and display to the text box
                    this.SourceText = results[0].formatted_address; // Set sourceLocation to the formatted address
                    
                
                    console.log(this.SourceText);
                }

            });
      },
      // this function is responsible for drawing out the line from source to destination
      calculateAndDisplayRoute(sourceCoordinate, destinationCoordinates) {


          this.directionsService = new google.maps.DirectionsService();
          this.directionsRenderer = new google.maps.DirectionsRenderer();

        

          

          let request = {
          origin: new google.maps.LatLng(sourceCoordinate.lat, sourceCoordinate.lng),
          destination: new google.maps.LatLng(destinationCoordinates.lat, destinationCoordinates.lng),
          travelMode:  this.typeOfTravelMode// You can change this to suit your needs (e.g., 'WALKING', 'BICYCLING')
          };

          console.log("Coordinate passed in",sourceCoordinate);
          console.log(destinationCoordinates);

          this.directionsService.route(request, (result, status) => {
          if (status === 'OK') {

            const map = this.$refs.googleMap.$mapObject; // Access the map instance ref to googleMap
            this.directionsRenderer.setMap(map); // Attach the DirectionsRenderer to the map

            if(this.typeOfTravelMode == "WALKING"){
                    //line options
                    this.directionsRenderer.setOptions({
                    suppressMarkers: true,
                    polylineOptions: {
                      strokeColor: "Red",
                      strokeOpacity: 0.8,
                      strokeWeight: 5
                    }
                  });
        

            }else{
                    //line options
                    this.directionsRenderer.setOptions({


                              
                suppressMarkers: true,
                polylineOptions: {
                  strokeColor: "#2ab3a6",
                  strokeOpacity: 0.8,
                  strokeWeight: 5
                }
                });
     
            }

         

              //render out the line
              this.directionsRenderer.setDirections(result);
          }
          });
      },

      getTravelMode(){

        if(sessionStorage.getItem('updateTravelMode')){
          const updatedTravelModeData = sessionStorage.getItem('updateTravelMode');
            console.log(updatedTravelModeData)
            
            if(updatedTravelModeData){

              this.typeOfTravelMode = updatedTravelModeData
      
            } else {
              // Handle the case where the data is not found in sessionStorage
              console.log('No shared data found for source.');
            }

        }





      }



  }
  
  
  ,
  mounted(){
    this.getGpsLocationCoord();
    this.getDatabaseLocationData();

  
    



  }
}






</script>

<template>

  
  <GMapMap :center="this.userSourceCoordinate" :zoom="15" map-type-id="terrain" style="width: 100%; height: 450px" ref="googleMap">



    <GMapCluster>
      
 

      <GMapMarker :key="manualIndex"  :position="this.userSourceCoordinate" :clickable="true" @click="openMarker1(1)"  :icon="{url: userMarkerIconImagePath,scaledSize: { width: 30, height: 35 },labelOrigin: { x: 16, y: -10 }}" class="custom-marker">
        
   


        <GMapInfoWindow :closeclick="true" @closeclick="openMarker1(null)" :opened="openedMarkerID1 === 1" >

          <div class="card" style="width: 18rem;">
          <img src="" class="card-img-top" alt="">
          <div class="card-body">
            <h5 class="card-title">Current Location:</h5>
            <p class="card-text">{{this.SourceText}} </p>
            
          </div>
        </div>
        
          
        </GMapInfoWindow>

      </GMapMarker>

      <GMapMarker :key="manualIndex2" :position="this.userDestinationCoordinate" :clickable="true" :icon="{url: destinationMarkerIconImagePath,scaledSize: { width: 30, height: 35 },labelOrigin: { x: 16, y: -10 }}"  @click="openMarker2(2)">

        <GMapInfoWindow :closeclick="true" @closeclick="openMarker2(null)" :opened="openedMarkerID2 === 2" >
          <div class="card" style="width: 18rem;">
          <img :src="destinationImage" class="card-img-top" alt="">
          <div class="card-body">
            <h5 class="card-title">{{this.destinationName}}</h5>
            <p class="card-text"> {{ this.destinationAddress }} </p>
            
          </div>
        </div>
          
        </GMapInfoWindow>

      </GMapMarker>

    </GMapCluster>


  </GMapMap>



</template>


<style>
.custom-marker {
  width: 40px; /* Customize the width as needed */
  height: 40px; /* Customize the height as needed */
  /* Other styling properties can be added here */
}
</style>
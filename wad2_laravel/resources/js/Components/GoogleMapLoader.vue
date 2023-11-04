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
        destinationAddress:null

      // markers: [
      //   {
      //     position: {
      //       lat: 51.093048, lng: 6.842120
      //     },
      //   }
      //   , // Along list of clusters
      // ],


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
              //update userSource COORD
              this.userSourceCoordinate = updateDataToUse
      
            } else {
              // Handle the case where the data is not found in sessionStorage
              console.log('No shared data found for source.');
            }

      const updatedDestinationCoordData = sessionStorage.getItem('destinationCoordinate');

      if(updatedDestinationCoordData){
        const updateDestinationCoordDataToUse = JSON.parse(updatedDestinationCoordData);

        this.userDestinationCoordinate = updateDestinationCoordDataToUse


   

        
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

      }
      // findNearestBookStore(currentCoord){
      //     if(sessionStorage.getItem('searchedSourceCoordinate')){
      //     const sourceData = sessionStorage.getItem('searchedSourceCoordinate');
      //         console.log(sourceData)
              
      //         if(sourceData){
      //           const sourceDataToUse = JSON.parse(sourceData);
      //           //update GPS COORD
      //           this.searchedSourceCoord =sourceDataToUse;

      //           // Now, GpsDataToUse contains the shared data
      //           console.log(sourceDataToUse);
      //           console.log(this.searchedSourceCoord);
      //         } else {
      //           // Handle the case where the data is not found in sessionStorage
      //           console.log('No shared data found.');
      //         }
      //   }



      // }


  }
  
  
  ,
  mounted(){
    this.getGpsLocationCoord();
    this.getDatabaseLocationData();

  
    



  }
}






</script>

<template>

  
  <GMapMap :center="this.userSourceCoordinate" :zoom="15" map-type-id="terrain" style="width: 100%; height: 500px">

    <GMapCluster>

 

      <GMapMarker :key="manualIndex"  :position="this.userSourceCoordinate" :clickable="true" @click="openMarker1(1)">
        
        <GMapInfoWindow :closeclick="true" @closeclick="openMarker1(null)" :opened="openedMarkerID1 === 1" >

          <div class="card" style="width: 18rem;">
          <img src="" class="card-img-top" alt="">
          <div class="card-body">
            <h5 class="card-title">Card title</h5>
            <p class="card-text">I am in info window 1 </p>
            <a href="#" class="btn btn-primary">Go somewhere</a>
          </div>
        </div>
        
          <p>{{userSourceCoordinate}}</p>
        </GMapInfoWindow>

      </GMapMarker>

      <GMapMarker :key="manualIndex2" :position="this.userDestinationCoordinate" :clickable="true"  @click="openMarker2(2)">

        <GMapInfoWindow :closeclick="true" @closeclick="openMarker2(null)" :opened="openedMarkerID2 === 2" >
          <div class="card" style="width: 18rem;">
          <img src="{{ this.destinationImage }}" class="card-img-top" alt="">
          <div class="card-body">
            <h5 class="card-title">{{this.destinationName}}</h5>
            <p class="card-text"> {{ this.destinationAddress }} </p>
            <a href="#" class="btn btn-primary">Go somewhere</a>
          </div>
        </div>
          <p>{{ userDestinationCoordinate }}</p>
        </GMapInfoWindow>

      </GMapMarker>

    </GMapCluster>


  </GMapMap>



</template>
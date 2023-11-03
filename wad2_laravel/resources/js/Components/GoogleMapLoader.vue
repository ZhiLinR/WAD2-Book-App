

<script>
export default {
  props: {
    destinationCoord: Object,
  },
  data() {
    return {
      userSourceCoordinate:null,
      center: null,
      dbLocationData: [],
      closestDistance:null,
      closestDistanceCoordinate:null,
      searchedSourceCoord:null,
      path: []


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
    getDatabaseLocationData(){
          for (let index = 0; ; index++) {
          const key = `DBlocationJson${index}`;
          const storedData = sessionStorage.getItem(key);
          if (storedData) {
            this.dbLocationData.push(JSON.parse(storedData));
          } else {
            break; // Stop when no more data is found
          }
        }

    },
    getSearchedSourceCoord(){
 

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
    console.log(this.destinationCoord)

    if(this.destinationCoord & this.userSourceCoordinate){
      this.path.push(this.destinationCoord);
      this.path.push(this.userSourceCoordinate)
    };

    console.log(this.path)

  }
}






</script>

<template>

  
  <GMapMap :center="this.userSourceCoordinate" :zoom="15" map-type-id="terrain" style="width: 100%; height: 500px">

    <GMapCluster>

      <GMapPolyline :path="path" :editable="true" ref="polyline" />
      <GMapMarker :key="index"  :position="this.userSourceCoordinate" :clickable="true" @click="center = this.userSourceCoordinate" />


    </GMapCluster>


  </GMapMap>



</template>
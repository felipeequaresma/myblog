<template>
  <div id="app">
     <router-view/>
  </div>
</template>

<script>
  
</script>

<style>
  *{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }
  @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@800&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&display=swap');
  body{
    background-color: #313131;
  }
  ::-webkit-scrollbar {
      width: 8px;
  }
    
  ::-webkit-scrollbar-thumb {
      -webkit-border-radius: 10px;
      border-radius: 10px;
      background-color: #313131;
  }
  ::-webkit-scrollbar-track-piece { 
      background: rgba(117, 117, 117, 0.8);  
  }
</style>

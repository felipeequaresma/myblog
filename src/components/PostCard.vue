<template>
    <div class="card">
        <div class="categories">
            <span>BACKEND</span>
            <span>PHP</span>
        </div>
        <div class="title">
            <h5>Material Kit PRO features</h5>
        </div>
        <div class="description">
            <p>Material Kit PRO features over 1000 
            individual components, giving you 
            the freedom of choosing and 
            combining. </p>
        </div>
        <div class="button">
            <router-link to="/teste">
                VER SOBRE
            </router-link>
        </div>
    </div>
</template>
<script>
export default {
    name: "post-card"
}
</script>
<style scoped>
    .card{
        background: #434343;
        border: 1px solid #3A903E;
        box-sizing: border-box;
        border-radius: 5px;
        width: 300px;
        height: 266px;
    }
    .card {
        padding:26px 26px;
    }
     .card .categories {
        padding: 0 0 26px 0;
    }
    .card .categories > span {
        border: 1px solid #3A903E; 
        padding:5px;
        font-family: Montserrat;
        font-size: 14px;
        line-height: 17px;
    }
    .card .title h5 {
        font-family: Montserrat;
        font-style: normal;
        font-weight: bold;
        font-size: 18px;
        line-height: 22px;
        text-align: center;
        color: #FFFFFF;
        padding: 0 0 7px 0;
    } 
     .card .description {
          padding:  0 0 26px 0;
     }
    .card .description p {
        font-family: Montserrat;
        font-style: normal;
        font-weight: normal;
        font-size: 14px;
        line-height: 17px;
        color: #FFFFFF;
        width: 250px;
    }
</style>
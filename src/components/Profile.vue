<template>
    <div class="profile">
        <img src="@/assets/perfil.png" alt="">
        <h3>Felipe Quaresma</h3>
        <div class="box">
            <span class="line top"></span>
            <p>Produtor de conteúdo e podcaster 
            no Grupo Alura.</p>
            <span class="line bottom"></span>
            <div class="social">
                <a href="">
                    <img src="@/assets/instagram.png" alt="" srcset="">
                </a>
                 <a href="">
                    <img src="@/assets/whatsapp.png" alt="" srcset="">
                </a>
                 <a href="">
                    <img src="@/assets/linkedin.png" alt="" srcset="">
                </a>
                 <a href="">
                    <img src="@/assets/github.png" alt="" srcset="">
                </a>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    name: "nav"
}
</script>
<style scoped>
    .profile {
        display: flex;
        flex-direction: column;
        align-items: center;
        flex-wrap: wrap;
    }
    .profile img {
        margin-top:73px;
        margin-bottom: 16px;
    }
    .profile h3 {
        font-family: Montserrat;
        font-style: normal;
        font-weight: bold;
        font-size: 20px;
        line-height: 24px;
        color: #FFFFFF;
    }
     .profile .box {
         display: flex;
         flex-direction: column;
         align-items: center;
         margin-top: 27px;

     }     
    .profile .box p{
        font-family: Montserrat;
        font-style: normal;
        font-weight: 300;
        font-size: 16px;
        line-height: 20px;
        text-align: center;
        color: #E5E5E5;
    }
    .profile .box .line{
        display: block;
        border-bottom: 1px solid rgba(72, 72, 72, 0.7);
     }
     .profile .box .line.top{
        width: 107px;
        margin: 0 auto 10px auto;
     }
    .profile .box .line.bottom{
        width: 75px;
        margin: 10px auto 0 auto;
    }
    .profile .box .social{
       display: flex;
       justify-content: space-evenly;
       width: 50%;
    }
    .profile .box .social a{
      padding: 5px;
    }
    @media only screen and (max-width: 360px)  { 
        .profile img {
            margin-top:12px;
            width: 50px;
        }
        .profile h3 {
            font-family: Montserrat;
            font-style: normal;
            font-weight: bold;
            font-size: 14px;
            color: #FFFFFF;
        }
        .box{
            display: none !important;
        }
    }   

</style>
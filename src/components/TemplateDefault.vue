<template>
    <div id="template">
        <header>
            <nav>
               <slot name="header"></slot>
            </nav>
        </header>
        <main>
            <slot name="section"></slot>
        </main>
        <footer>
            <slot name="footer"></slot>
         </footer>
    </div>
</template>
<script>
    export default {
      name: 'TemplateDefault',
    }
</script>
<style scoped>

    #template{
      display: flex;
    }
    #template nav {
      width: 100%;
      max-width: 25%;
      height: 100vh;
      position: fixed;
      display: block;
      background-color: #1D1D1D;
    }
    #template main {
      width: 75%;
      margin-left: auto;     
      height: 100%;
      color:#fff;
    }
    #template main > div{
        margin-top:107px;
        padding: 0 40px;
    }

  @media only screen and (max-width: 360px)  {
    #template {
      display: block;
    }
    #template nav {
      position: static;
      max-width: 100%;
      height: 123px;
    }
    #template main {
      width: 100%;
    }
    #template main > div{
        margin-top:32px;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }
  }
</style>
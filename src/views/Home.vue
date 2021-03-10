<template>
  <section class="home">
    <base-layout>
        <template v-slot:header>
              <profile></profile>
        </template>
         <template v-slot:section>
           <div>
              <post-card></post-card>
           </div>
        </template>
    </base-layout>
  </section>
</template>

<script>
  import BaseLayout from "@/components/TemplateDefault";
  import PostCard from '@/components/PostCard';
  import Profile from '@/components/Profile';


  export default {
    name: 'Home',
    components: {
        BaseLayout,
        PostCard,
        Profile
    }
}
</script>
<style scoped>
  /* .home{
    height:1000px;
  } */
</style>


import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '@/views/HomeView.vue';
import LessonView from '@/views/LessonView.vue';
import ArenaChoice from '@/views/ArenaChoice.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
     {
      path: '/',
      name: 'home',
      component: HomeView,
    },
    {
      path: '/lessons/:id',
      name: 'lesson',
      component: LessonView,
      props: true, 
    },
      {
      path: '/arenachoice',
      name: 'arenachoice',
      component: ArenaChoice,
    },
  ],
})

export default router

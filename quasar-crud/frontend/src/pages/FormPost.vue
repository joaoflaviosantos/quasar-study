<template>
  <q-page padding>
    <div class="q-pa-md">
      <q-form
      @submit="onSubmit"
      class="row q-col-gutter-md"
      >
        <q-input
        outlined
        v-model="form.title"
        label="Title *"
        lazy-rules
        :rules="[ val => val && val.length > 0 || 'Please type something']"
        class="col-md-8 col-xs-12"
        />
        <q-input
        outlined
        v-model="form.author"
        label="Author *"
        lazy-rules
        :rules="[ val => val && val.length > 0 || 'Please type something']"
        class="col-md-4 col-xs-12"
        />
        <div class="col-md-12">
          <q-editor
            v-model="form.content"
            min-height="8rem"
          />
        </div>
        <div class="col-md-12 q-gutter-sm">
          <q-btn
            label="Save"
            icon="save"
            color="primary"
            class="float-right"
            type="submit"
          />
          <q-btn
            label="Cancel"
            color="white"
            text-color="primary"
            class="float-right"
            :to="{ name: 'home' }"
          />
        </div>
      </q-form>
    </div>
  </q-page>
</template>


<script>
import { defineComponent, ref, onMounted } from "vue";
import postsService from "src/services/posts"
import { useQuasar } from 'quasar'
import { useRouter, useRoute } from 'vue-router'

export default defineComponent ({
  name: "FormPost",

  setup() {

    const { post, getById, update } = postsService()
    const $q = useQuasar()
    const router = useRouter()
    const route = useRoute()
    const form = ref({
      title: '',
      author: '',
      content: ''
    })

    onMounted( async () => {
      if (route.params.id) {
        try {
          const response = await getById(route.params.id)
          form.value = response
        } catch (error) {
          router.push({ name: "home" })
        }
      }
    })

    const onSubmit = async () => {
      try {
        if (form.value.id) {
          await update(form.value)
          $q.notify({ message: `Post ${form.value.id} successfully updated!`, color: 'positive', icon: 'check' })
          router.push({ name: "home" })
        } else {
          await post(form.value)
          $q.notify({ message: `Post successfully created!`, color: 'positive', icon: 'check' })
          router.push({ name: "home" })
        }

      } catch (error) {
        alert(error)
      }
    }

    return {
      form,
      onSubmit
    }
  },

})
</script>


<style>

</style>

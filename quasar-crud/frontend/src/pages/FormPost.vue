<template>
  <q-page padding>
    <div class="q-pa-md">
      <q-form
      @submit="onSubmit"
      @reset="onReset"
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
import { defineComponent, ref } from "vue";
import postsService from "src/services/posts"
import { useQuasar } from 'quasar'
import { useRouter } from 'vue-router'

export default defineComponent ({
  name: "FormPost",

  setup() {

    const $q = useQuasar()

    const router = useRouter()

    const form = ref({
      title: '',
      author: '',
      content: ''
    })

    const { post } = postsService()

    const onSubmit = async () => {
      try {
        await post(form.value)
        $q.notify({ message: `Post successfully created!`, color: 'positive', icon: 'check' })
        router.push({ name: "home" })
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

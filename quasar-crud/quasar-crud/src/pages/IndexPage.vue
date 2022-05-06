<template>
  <q-page padding>
    <div class="q-pa-md">
      <q-table
        title="Posts"
        :rows="rows"
        :columns="columns"
        row-key="name"
      />
    </div>
  </q-page>
</template>

<script>
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'IndexPage',
  setup () {

  }
})
</script>

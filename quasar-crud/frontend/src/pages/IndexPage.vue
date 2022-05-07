<template>
  <q-page padding>
    <div class="q-pa-md">
      <q-table title="Posts" :rows="posts" :columns="columns" row-key="name" />
    </div>
  </q-page>
</template>

<script>
import { defineComponent, ref } from "vue";

export default defineComponent({
  name: "IndexPage",
  setup() {
    const posts = ref([]);

    const columns = [
      { name: 'id', field: 'id', label: 'Id', sortable: true, align: 'left'},
      { name: 'title', field: 'title', label: 'Title', sortable: true, align: 'left' },
      { name: 'author', field: 'author', label: 'Author', sortable: true, align: 'left' },
    ]

    return {
      posts,
      columns
    };
  },
});
</script>

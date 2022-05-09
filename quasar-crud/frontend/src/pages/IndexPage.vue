<template>
  <q-page padding>
    <div class="q-pa-md">
      <q-table
      title="Posts"
      :rows="posts"
      :columns="columns"
      row-key="name"
      />
    </div>
  </q-page>
</template>

<script>
import { defineComponent, ref, onMounted } from "vue";
import { api } from 'boot/axios'

export default defineComponent({
  name: "IndexPage",
  setup() {
    const posts = ref([]);

    const columns = [
      { name: 'id', field: 'id', label: 'Id', sortable: true, align: 'left' },
      { name: 'title', field: 'title', label: 'Title', sortable: true, align: 'left' },
      { name: 'author', field: 'author', label: 'Author', sortable: true, align: 'left' },
      { name: 'actions', field: 'actions', label: 'Actions', sortable: false, align: 'left' }
    ];

    onMounted(() => {
      getPost();
    });

    const getPost = async () => {
      try {
        const { data } = await api.get('posts');
        posts.value = data;
      } catch (error) {
        console.log(error);
      }
    };

    return {
      posts,
      columns
    };
  },
});
</script>

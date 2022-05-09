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
import postsService from "src/services/posts"

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

    const { list } = postsService();

    const getPost = async () => {
      try {
        const data = await list();
        posts.value = data;
      } catch (error) {
        console.log(error);
      }
    };

    onMounted(() => {
      getPost();
    });

    return {
      posts,
      columns
    };
  },
});
</script>

<template>
  <q-page padding>
    <div class="q-pa-md">
      <q-table
      title="Posts"
      :rows="posts"
      :columns="columns"
      row-key="name"
      >
      <!--<template v-slot:body-cell-actions="props">-->
      <template #body-cell-actions="props">
      <q-td :props="props">
      <q-btn icon="delete" color="negative" dense size="sm" @click="handleDeletePost(props.row.id)"/>
      </q-td>
      </template>
      </q-table>
    </div>
  </q-page>
</template>

<script>
import { defineComponent, ref, onMounted } from "vue";
import postsService from "src/services/posts"
import { useQuasar } from 'quasar'

export default defineComponent({
  name: "IndexPage",
  setup() {

    const $q = useQuasar()

    const columns = [
      { name: 'id', field: 'id', label: 'Id', sortable: true, align: 'left' },
      { name: 'title', field: 'title', label: 'Title', sortable: true, align: 'left' },
      { name: 'author', field: 'author', label: 'Author', sortable: true, align: 'left' },
      { name: 'actions', field: 'actions', label: 'Actions', sortable: false, align: 'center' }
    ];

    const posts = ref([]);

    const { list, remove } = postsService();

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

    const handleDeletePost = async (id) => {
      try {

        $q.dialog({
        title: 'Confirm',
        message: `Do you really want to delete Post ${id}?`,
        cancel: true,
        persistent: true
        }).onOk(async () => {
        await remove(id);
        $q.notify({ message: `Post ${id} deleted!`, color: 'positive', icon: 'check' })
        await getPost()
        })
      } catch (error) {
        //alert(error);
        $q.notify({ message: `Error on delete Post ${id}`, color: 'negative', icon: 'times' })
      }
    }

    return {
      posts,
      columns,
      handleDeletePost
    };

  },
});
</script>

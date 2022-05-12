<template>
  <q-page padding>
    <div class="q-pa-md">
      <q-table
      title="Posts"
      :rows="posts"
      :columns="columns"
      row-key="name"
      >
        <template #top>
          <span class="text-h5">Posts</span>
          <q-space />
          <q-btn color="primary" label="Add Post" :to="{ name: 'formPost' }" />
        </template>
        <!--<template v-slot:body-cell-actions="props">-->
        <template #body-cell-actions="props" >
          <q-td :props="props" class="q-gutter-sm">
          <q-btn icon="edit" color="warning" dense size="sm" @click="handleEditPost(props.row.id)"/>
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
import { useRouter } from "vue-router";

export default defineComponent({
  name: "IndexPage",
  setup() {

    const $q = useQuasar()

    const router = useRouter()

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

    const handleEditPost = async (id) => {
      try {
        router.push({ name: 'formPost', params: { id } })
      } catch (error) {
        $q.notify({ message: `Could not edit Post ${id}`, color: 'negative', icon: 'times' })
      }
    }

    return {
      posts,
      columns,
      handleDeletePost,
      handleEditPost
    };

  },
});
</script>

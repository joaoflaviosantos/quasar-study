import useApi from "src/composables/UseApi"

export default function postsService () {

  const { list, getById, post, update, remove } = useApi('posts')

  return {
    list,
    getById,
    post,
    update,
    remove
  }

}

function escapeHTML(str) {
  return str.replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;')
}

async function getPosts() {
  response = await axios.get('/api/posts')
  return response.data.posts
}

async function reloadPostsTableBody() {
  const posts = await getPosts()
  const innerHTML = posts.map(p => `<tr><td>${escapeHTML(p.message)}</td><td>${escapeHTML(p.createdAt)}</td></tr>`)
    .reduce((l, r) => l + r)

  const tableBody = document.getElementById("posts-table-body")
  tableBody.innerHTML = innerHTML
}

reloadPostsTableBody()

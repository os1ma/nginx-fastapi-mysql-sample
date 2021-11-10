function escapeHTML(str) {
  return str
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;')
}

async function reloadPosts() {
  const tableBody = document.querySelector('#posts-table-body')

  const response = await axios.get('/api/posts')
  console.log(response)
  const posts = response.data.posts

  while (tableBody.firstChild) {
    tableBody.removeChild(tableBody.firstChild)
  }

  posts.forEach((p) => {
    const tr = document.createElement('tr')

    const tdMessage = document.createElement('td')
    tdMessage.textContent = escapeHTML(p.message)
    tr.appendChild(tdMessage)
    const tdCreatedAt = document.createElement('td')
    tdCreatedAt.textContent = escapeHTML(p.createdAt)
    tr.appendChild(tdCreatedAt)

    tableBody.appendChild(tr)
  })
}

async function registerPost() {
  const message = document.querySelector('#input-text').value

  if (!message) {
    return
  }

  await axios.post('/api/posts', {
    message
  })

  await reloadPosts()
}

document.querySelector('#submit-button').addEventListener('click', registerPost)

reloadPosts()

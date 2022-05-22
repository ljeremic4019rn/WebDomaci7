<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <%@ include file="styles.jsp" %>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="container">
    <h1 class="naslov">Posts:</h1>

    <br>
    <br>

    <div id="subject-links">

    </div>
</div>

<script>
    fetch('/api/posts', {
        method: 'GET'
    }).then(response => {
        return response.json();
    }).then(posts => {
        for (const post of posts) {
            addSubjectElements(post)
        }
    })

    function addSubjectElements(post) {
        const subjectLinks = document.getElementById('subject-links');

        const linkWrapperDiv = document.createElement('div');
        linkWrapperDiv.classList.add('container', 'border')

        const subjectLink = document.createElement('a');
        subjectLink.innerText = post.name;
        subjectLink.href = '/posts/' + post.id;

        const title = document.createElement('h3');
        title.textContent = post.title;

        const content = document.createElement('small');
        content.textContent = post.content;


        // const removeButton = document.createElement('button');
        // removeButton.innerText = 'Remove'
        // removeButton.classList.add('btn', 'btn-danger', 'btn-sm')
        // removeButton.style.marginLeft = '10px'
        // removeButton.onclick = function (e) {
        //     deleteSubject(post.id).then(() => {
        //         subjectLinks.removeChild(linkWrapperDiv)
        //     });
        // }

        linkWrapperDiv.appendChild(subjectLink);
        linkWrapperDiv.appendChild(title);
        linkWrapperDiv.appendChild(content);
        // linkWrapperDiv.appendChild(document.createElement('br'));
        // linkWrapperDiv.appendChild(document.createElement('br'));
        // linkWrapperDiv.appendChild(removeButton);
        linkWrapperDiv.appendChild(document.createElement('br'));
        linkWrapperDiv.appendChild(document.createElement('br'));

        subjectLinks.appendChild(linkWrapperDiv);
    }

    // function deleteSubject(id) {
    //     return fetch('/api/posts/'+id, {
    //         method: 'DELETE'
    //     })
    // }

    // document.getElementById("subject-form").addEventListener('submit', function(e) {
    //     e.preventDefault();
    //
    //     const subjectTitleElement = document.getElementById('subject-title');
    //     const contentElement = document.getElementById('subject-content');
    //
    //     const title = subjectTitleElement.value;
    //     const content = contentElement.value;
    //
    //     fetch('/api/subjects', {
    //         method: 'POST',
    //         headers: {
    //             'Content-Type': 'application/json'
    //         },
    //         body: JSON.stringify({
    //             title: title,
    //             content: content
    //         })
    //     }).then(response => {
    //         return response.json();
    //     }).then(subject => {
    //         addSubjectElements(subject)
    //         subjectTitleElement.value = '';
    //         contentElement.value = '';
    //     })
    // })
</script>
</body>
</html>


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


    <div id="posts">
    </div>
    <br>
    <button id="new-post-btn" class="btn-sm btn-primary">New post</button>


    <div id="new-post" style="display: none">
        <form method="POST" id="post-form">
            <div class="form-group">
                <label for="post-name">Name</label>
                <input type="text" class="form-control" id="post-name" placeholder="Enter post name">

                <label for="post-title">Title</label>
                <input type="text" class="form-control" id="post-title" placeholder="Enter post title">

                <label for="post-content">Content</label>
                <textarea class="form-control" id="post-content"></textarea>

            </div>
            <button type="submit" class="btn-sm btn-primary">Submit</button>
        </form>
    </div>


    <div id="single-post" style="display: none">
        <h1 id="sPost-name"></h1>
        <h2 id="sPost-title"></h2>
        <h6 id="sPost-date"></h6>
        <br>
        <hr>
        <small id="sPost-content"></small>

        <br>
        <hr>

        <div id="sPost-comments">
        </div>

        <form method="POST" id="comment-form">
            <div class="form-group">
                <label for="comment-name">Username</label>
                <input type="text" class="form-control" id="comment-name" placeholder="Enter username">

                <label for="comment-text">Comment text</label>
                <textarea class="form-control" id="comment-text" placeholder="Comment text"> </textarea>
            </div>
            <button type="submit" class="btn-sm btn-primary">Submit</button>
        </form>
    </div>
</div>


<script>
    let singlePostId = null;//holder za id trenutno kliknutok posta


    fetch('/api/posts', {//fetchovanje svih postova
        method: 'GET'
    }).then(response => {
        return response.json();
    }).then(posts => {
        for (const post of posts) {
            addPostElements(post)
        }
    })

    document.getElementById("new-post-btn").addEventListener("click", () => {//kada se klikne new post menja se ekran
        document.getElementById("new-post-btn").style.display = "none";
        document.getElementById("single-post").style.display = "none";
        document.getElementById("posts").style.display = "none";
        document.getElementById("new-post").style.display = "block";
    }, false);

    function addPostElements(post) {
        const subjectLinks = document.getElementById('posts');//dodavanje posta u listu postova

        const linkWrapperDiv = document.createElement('div');
        linkWrapperDiv.classList.add('container', 'border');

        const subjectLink = document.createElement('a');
        subjectLink.innerText = post.name;
        subjectLink.style.fontSize = "xx-large";
        subjectLink.href = "#";
        subjectLink.addEventListener("click", () => {
            document.getElementById("posts").style.display = "none";
            document.getElementById("new-post-btn").style.display = "none";
            document.getElementById("single-post").style.display = "block";

            getSinglePost(post.id)
        }, false);

        const title = document.createElement('h5');
        title.textContent = post.title;
        const content = document.createElement('small');
        content.textContent = post.content;

        linkWrapperDiv.appendChild(subjectLink);
        linkWrapperDiv.appendChild(title);
        linkWrapperDiv.appendChild(content);
        linkWrapperDiv.appendChild(document.createElement('br'));
        linkWrapperDiv.appendChild(document.createElement('br'));

        subjectLinks.appendChild(linkWrapperDiv);
    }

    document.getElementById("post-form").addEventListener('submit', function (e) {//dodavanje novog posta na bazu
        e.preventDefault();
        const postNameElement = document.getElementById('post-name');
        const postTitleElement = document.getElementById('post-title');
        const postContentElement = document.getElementById('post-content');

        const name = postNameElement.value;
        const title = postTitleElement.value;
        const content = postContentElement.value;
        let date = new Date(Date.now()).toLocaleString().split(',')[0];

        if (name === "" || title === "" || content === ""){
            alert("You have to fill in all fields");
            return;
        }


        fetch('/api/posts', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                name: name,
                title: title,
                content: content,
                date: date,
            })
        }).then(response => {
            return response.json();
        }).then(subject => {
            addPostElements(subject)
            postNameElement.value = '';
            postTitleElement.value = '';
            postContentElement.value = '';

            makePostsVisible();
        })

    })

    function makePostsVisible() {
        document.getElementById("posts").style.display = "block";//vracanje postova na home screen
        document.getElementById("new-post-btn").style.display = "none";
        document.getElementById("new-post").style.display = "none";
    }

    document.getElementById("comment-form").addEventListener('submit', function (e) {//dodavanje novog posta na bazu
        e.preventDefault();

        const commentName = document.getElementById('comment-name');
        const commentText = document.getElementById('comment-text');

        const name = commentName.value;
        const text = commentText.value;

        commentName.value = '';
        commentText.value = '';


        if ((name === "" || text === "") || (name === null || text === null)){
            alert("You have to fill in all fields");
            return;
        }

        fetch('/api/comments', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                postId: singlePostId,
                name: name,
                text: text
            })
        })
            .then(response => {
            return response.json();
        }).then(comment => {
            addComment(comment)
        })
    })

    function getSinglePost(id) {//uzimanje jednog posta iz baze
        fetch('/api/posts/' + id, {
            method: 'GET'
        }).then(response => {
            return response.json();
        }).then(post => {

            document.getElementById("sPost-name").textContent = post.name;
            document.getElementById("sPost-title").textContent = post.title;
            document.getElementById("sPost-content").textContent = post.content;
            document.getElementById("sPost-date").textContent = post.date;

            singlePostId = id;
            getCommentsForPost(id)
        })
    }

    function getCommentsForPost(postId) {//uzimanje komentara iz baze i filtriranje za selektovani post
        fetch('/api/comments/', {
            method: 'GET'
        }).then(response => {
            return response.json();
        }).then(comments => {

            for (const comment of comments) {
                if (comment.postId === postId) {
                    addComment(comment)
                }
            }
        })
    }

    function addComment(comment) {
        const div = document.createElement('div');//dodavanje komentara u listu
        div.classList.add('container');
        const commentTitle = document.createElement('h5');
        commentTitle.textContent = comment.name;
        const commentContent = document.createElement('small');
        commentContent.textContent = comment.text;
        const br = document.createElement('hr');

        div.appendChild(commentTitle);
        div.appendChild(commentContent);
        div.appendChild(br);
        document.getElementById("sPost-comments").appendChild(div);
    }
</script>
</body>
</html>


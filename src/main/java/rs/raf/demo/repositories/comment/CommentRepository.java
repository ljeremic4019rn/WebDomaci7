package rs.raf.demo.repositories.comment;


import rs.raf.demo.entities.Comment;

import java.util.List;

public interface CommentRepository  {
    public Comment addComment(Comment comment);
    public List<Comment> allComments();
    public Comment findComment(Integer id);
    public void deleteComment(Integer id);
}

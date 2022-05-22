package rs.raf.demo.entities;

public class Comment {

    private int id;
    private int postId;
    private String name;
    private String text;

    public Comment(int id, int postId, String name, String text) {
        this.id = id;
        this.postId = postId;
        this.name = name;
        this.text = text;
    }

    public Comment(){
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}

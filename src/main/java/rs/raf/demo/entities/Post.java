package rs.raf.demo.entities;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

public class Post {
    private int id;
    @NotNull(message = "Title field is required")
    @NotEmpty(message = "Title field is required")
    private String name;
    @NotNull(message = "Title field is required")
    @NotEmpty(message = "Title field is required")
    private String title;
    @NotNull(message = "Title field is required")
    @NotEmpty(message = "Title field is required")
    private String content;
    @NotNull(message = "Title field is required")
    @NotEmpty(message = "Title field is required")
    private String date;

    public Post(int id, String name, String title, String content, String date) {
        this.id = id;
        this.name = name;
        this.title = title;
        this.content = content;
        this.date = date;
    }

    public Post(){
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}

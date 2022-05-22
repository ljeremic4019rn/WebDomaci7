package rs.raf.demo;

import org.glassfish.hk2.utilities.binding.AbstractBinder;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.server.ServerProperties;
import rs.raf.demo.repositories.comment.CommentRepository;
import rs.raf.demo.repositories.comment.MySQLCommentRepository;
import rs.raf.demo.repositories.post.MySQLPostRepository;
import rs.raf.demo.repositories.post.PostRepository;
import rs.raf.demo.repositories.subject.InMemorySubjectRepository;
import rs.raf.demo.repositories.subject.MySqlSubjectRepository;
import rs.raf.demo.repositories.subject.SubjectRepository;
import rs.raf.demo.services.CommentService;
import rs.raf.demo.services.PostService;
import rs.raf.demo.services.SubjectService;

import javax.inject.Singleton;
import javax.ws.rs.ApplicationPath;

@ApplicationPath("/api")
public class HelloApplication extends ResourceConfig {

    public HelloApplication() {
        // Ukljucujemo validaciju
        property(ServerProperties.BV_SEND_ERROR_IN_RESPONSE, true);

        // Definisemo implementacije u dependency container-u
        AbstractBinder binder = new AbstractBinder() {
            @Override
            protected void configure() {
//                this.bind(MySqlSubjectRepository.class).to(SubjectRepository.class).in(Singleton.class);
                this.bind(MySQLCommentRepository.class).to(CommentRepository.class).in(Singleton.class);
                this.bind(MySQLPostRepository.class).to(PostRepository.class).in(Singleton.class);

                this.bindAsContract(CommentService.class);
                this.bindAsContract(PostService.class);
//                this.bindAsContract(SubjectService.class);
            }
        };
        register(binder);

        // Ucitavamo resurse
        packages("rs.raf.demo.resources");
    }
}

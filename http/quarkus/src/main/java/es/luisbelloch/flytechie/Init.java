package es.luisbelloch.flytechie;

import io.quarkus.runtime.StartupEvent;
import io.vertx.mutiny.pgclient.PgPool;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.event.Observes;

@ApplicationScoped
public class Init {

    private final PgPool client;

    public Init(PgPool client) {
        this.client = client;
    }

    void onStart(@Observes StartupEvent ev) {
        client.query("drop table if exists orders").execute()
                .flatMap(r -> client.query("create table orders (id serial primary key, flavour varchar(20), size varchar(2))").execute())
                .await().indefinitely();
    }
}

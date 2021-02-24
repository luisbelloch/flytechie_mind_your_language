package es.luisbelloch.flytechie;

import io.smallrye.mutiny.Uni;
import io.vertx.mutiny.pgclient.PgPool;
import io.vertx.mutiny.sqlclient.Tuple;

import javax.enterprise.context.ApplicationScoped;
import java.io.IOException;

@ApplicationScoped
public class OrdersRepository {

    private final PgPool client;

    public OrdersRepository(PgPool client) {
        this.client = client;
    }

    public Uni<String> save(Order order) throws IOException {
        return client
                .preparedQuery("INSERT INTO orders (flavour, size) VALUES ($1, $2) RETURNING (id)")
                .execute(Tuple.of(order.flavour, order.size))
                .onItem().transform(pgRowSet -> "{\"id\":" + pgRowSet.iterator().next().getInteger("id") + "}");
    }
}

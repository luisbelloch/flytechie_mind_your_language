package es.luisbelloch.flytechie;

import io.smallrye.mutiny.Uni;

import javax.inject.Inject;
import javax.transaction.Transactional;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import java.io.IOException;

@Path("/orders")
@Consumes("application/json")
@Produces("application/json")
public class OrdersResource {

    private final OrdersRepository repository;

    @Inject
    public OrdersResource(OrdersRepository repository) {
        this.repository = repository;
    }

    @POST
    @Transactional
    @Path("/create")
    public Uni<String> create(Order order) throws IOException {
        return repository.save(order);
    }
}
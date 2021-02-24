package es.luisbelloch.flytechie;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

@SuppressWarnings("CdiInjectionPointsInspection")
public class Order {
    public final String flavour;
    public final String size;

    @JsonCreator
    public Order(@JsonProperty("flavour") String flavour, @JsonProperty("size") String size) {
        this.flavour = flavour;
        this.size = size;
    }
}

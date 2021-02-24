RUNNER:=./target/quarkus_pancakes-1.0.0-SNAPSHOT-runner
FAST_JAR:=./target/quarkus-app/quarkus-run.jar

.PHONY: dev
dev:
	./mvnw compile quarkus:dev

.PHONY: clean
clean:
	./mvnw clean

.PHONY: run
run: $(FAST_JAR)
	java -jar $(FAST_JAR)

$(RUNNER).jar:
	./mvnw clean package -Dquarkus.package.type=uber-jar

$(FAST_JAR):
	./mvnw clean package -Dquarkus.package.type=fast-jar

.PHONY: container
container:
	./mvnw clean package -Dquarkus.container-image.build=true

.PHONY: native
native: $(RUNNER)

.PHONY: native_run
native_run: $(RUNNER)
	$(RUNNER)

$(RUNNER):
	./mvnw package -Pnative

.PHONY: native_container
native_container:
	./mvnw package -Pnative -Dquarkus.native.container-build=true -Dquarkus.container-image.build=true

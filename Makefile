all: server

.PHONY: all server clean cleanall

server: 
	$(MAKE) -C server

cleanall: 
	$(MAKE) -C apps clean
	$(MAKE) -C server clean
	
clean:
	$(MAKE) -C server clean

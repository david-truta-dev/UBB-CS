from Domain.Drone import Drone
from Repo.Map import Map
from Service.Service import Service

# run the main function only if this module is executed as the main script
# (if you import this as a module then nothing is executed)
if __name__ == "__main__":
    serv = Service(Drone(0, 0), Map())
    serv.run()

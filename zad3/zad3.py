from __future__ import annotations
import logging
from typing import List
from random import randint
from abc import ABC, abstractmethod
import time


class Computer(ABC):
    """
    The Computer interface declares a set of methods for managing subscribers.
    """

    @abstractmethod
    def attach(self, observer: Observer) -> None:
        """
        Attach an observer to the subject.
        """
        pass

    @abstractmethod
    def notify(self) -> None:
        """
        Notify all observers about an event.
        """
        pass


class ConcreteComputer(Computer):
    """
    The Computer owns some important state and notifies observers.
    """

    _observers: List[Observer] = []

    def attach(self, observer: Observer) -> None:
        self._observers.append(observer)

    def notify(self) -> None:
        for observer in self._observers:
            observer.update(self)

    def run(self) -> None:
        self.notify()
        time.sleep(randint(1, 4))
        self.run()


class Observer(ABC):
    """
    The Observer interface declares the update method, used by subjects.
    """

    @abstractmethod
    def update(self, subject: Computer) -> None:
        """
        Receive update from subject.
        """
        pass


class Engine(Observer):
    def __init__(self, temperature):
        self.temperature = temperature

    def update(self, subject: Computer) -> None:
        logging.info("Engine temperature: %d C", self.temperature)
        self.temperature = randint(60, 80)


class SteeringWheel(Observer):
    def __init__(self, turning_radius):
        self.turning_radius = turning_radius

    def update(self, subject: Computer) -> None:
        logging.info("Turning radius: %d", self.turning_radius)
        self.turning_radius = randint(-50, 50)


if __name__ == "__main__":
    # The client code.
    format = "%(asctime)s: %(message)s"
    logging.basicConfig(format=format, level=logging.INFO,
                        datefmt="%H:%M:%S")

    computer = ConcreteComputer()

    engine = Engine(70)
    computer.attach(engine)

    steering_wheel = SteeringWheel(30)
    computer.attach(steering_wheel)

    computer.run()

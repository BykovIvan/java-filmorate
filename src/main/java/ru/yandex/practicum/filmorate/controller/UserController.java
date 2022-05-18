package ru.yandex.practicum.filmorate.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import ru.yandex.practicum.filmorate.exceptions.ValidationException;
import ru.yandex.practicum.filmorate.model.User;

import javax.validation.Valid;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@Slf4j
@RequestMapping("/users")
public class UserController {
    private final Map<String, User> mapUsers = new HashMap<>();

    @PostMapping
    public User create(@Valid @RequestBody User user) {
        log.info("Получен запрос к эндпоинту /users. Метод POST");
        checkUser(user);
        if (mapUsers.containsKey(user.getLogin())) {
            throw new ValidationException("Такой пользователь уже зарегестрирован");
        }
        mapUsers.put(user.getLogin(), user);
        return user;

    }

    @PutMapping
    public User update(@Valid @RequestBody User user) {
        log.info("Получен запрос к эндпоинту /users. Метод PUT");
        checkUser(user);
        mapUsers.put(user.getLogin(), user);
        return user;
    }

    @GetMapping
    public List<User> giveAllFilms() {
        return new ArrayList<>(mapUsers.values());
    }

    //Проверка валидации фильмов
    private void checkUser(User user) throws ValidationException {
        if (user.getName() == null) {
            user.setName(user.getLogin());
        }
        if (user.getBirthday().isAfter(LocalDate.now())) {
            throw new ValidationException("Дата рождения не может быть в будущем");
        }
    }

}

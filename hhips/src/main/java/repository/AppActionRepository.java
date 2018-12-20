package repository;

import model.AppAction;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Service;

public interface AppActionRepository extends CrudRepository<AppAction, Integer> {

}
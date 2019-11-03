package repository;

import db.WorkCorrect;
import model.AppAction;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Repository
public interface WorkCorrectRepository extends CrudRepository<WorkCorrect, Integer> {
}

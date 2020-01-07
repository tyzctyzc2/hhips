package repository;

import dbmodel.WorkCorrect;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StageRepository extends CrudRepository<WorkCorrect, Integer> {
}
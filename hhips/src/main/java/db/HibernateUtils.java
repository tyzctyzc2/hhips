package db;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtils {
	private static SessionFactory sFactory=buildSessionFactory();
    
	   private static SessionFactory buildSessionFactory() throws HibernateException {
		   try {
				Configuration cfg = new Configuration();
				cfg.configure("hibernate.cfg.xml");
				// factory = new Configuration().configure().buildSessionFactory();
				sFactory = cfg.buildSessionFactory();
			} catch (Throwable ex) {
				System.err.println("Failed to create sessionFactory object." + ex);
				sFactory = null;
			}
		   
	       return sFactory;
	   }

	   public static Session openCurrentSession(){
		   if (sFactory == null) {
			   System.out.println("create session factory!!!!!");
			   buildSessionFactory();
		   }
	      return sFactory.getCurrentSession();
	   }
}

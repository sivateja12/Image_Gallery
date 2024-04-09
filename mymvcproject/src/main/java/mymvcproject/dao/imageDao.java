package mymvcproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import mymvcproject.model.Image;

@Component
public class imageDao {

	@Autowired
	HibernateTemplate hibernateTemplate;
	
	@Transactional
	public int insert(Image image) {
		int res=(int)this.hibernateTemplate.save(image);
		return res;
	}
	
	public List<Image> getAllImages(){
		return this.hibernateTemplate.loadAll(Image.class);
	}
	
	@Transactional
	public void delete(int id) {
		Image image=this.hibernateTemplate.get(Image.class,id);
		this.hibernateTemplate.delete(image);
	}
	
	public Image get(int id) {
		return this.hibernateTemplate.get(Image.class, id);
	}
	
	
	
	

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
	
	
	
}

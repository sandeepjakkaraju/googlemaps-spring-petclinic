package org.springframework.samples.petclinic.model;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;
import com.vividsolutions.jts.geom.Point;
import org.hibernate.annotations.Type;

@Entity
@Table(name="users_current_location")
public class UsersLocation implements Serializable {

    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}

	@OneToOne
	private Users user;

	@Type(type="org.hibernate.spatial.GeometryType")
	private Point currentLocation;

	public Point getCurrentLocation(){
		return currentLocation;
	}

	public void setCurrentLocation(Point currentLocation) {
		this.currentLocation = currentLocation;
	}

	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}
}
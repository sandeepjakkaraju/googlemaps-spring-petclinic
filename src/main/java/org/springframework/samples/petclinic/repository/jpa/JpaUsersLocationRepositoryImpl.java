/*
 * Copyright 2002-2013 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.springframework.samples.petclinic.repository.jpa;

import com.vividsolutions.jts.geom.Point;
import org.springframework.samples.petclinic.model.Users;
import org.springframework.samples.petclinic.model.UsersLocation;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

/**
 * JPA implementation of the {@link OwnerRepository} interface.
 *
 * @author Mike Keith
 * @author Rod Johnson
 * @author Sam Brannen
 * @author Michael Isvy
 * @since 22.4.2006
 */
@Repository
public class JpaUsersLocationRepositoryImpl {

    @PersistenceContext
    private EntityManager em;


    public Users getUser(String username) {
        List<Users> l = em.createQuery("SELECT n FROM Users n WHERE n.username = :name").setParameter("name", username)
                .getResultList();
        if (!l.isEmpty()) {
            Users user = l.get(0);
            return user;
        }
        return null;
    }

    public void saveUserLocation(String user, Point location) {

        UsersLocation loc = new UsersLocation();
        loc.setCurrentLocation(location);
        loc.setUser(this.getUser(user));

        this.em.persist(loc);
    }
}

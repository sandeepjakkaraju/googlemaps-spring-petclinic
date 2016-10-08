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
package org.springframework.samples.petclinic.web;

import com.vividsolutions.jts.geom.Coordinate;
import com.vividsolutions.jts.geom.Point;
import com.vividsolutions.jts.io.ParseException;
import com.vividsolutions.jts.io.WKTReader;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.samples.petclinic.model.Users;
import org.springframework.samples.petclinic.service.ClinicService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

/**
 * @author Juergen Hoeller
 * @author Ken Krebs
 * @author Arjen Poutsma
 */
@Controller
public class LocationController {

    @Autowired
    ClinicService impl;

    @RequestMapping(value = "/location.do", method = RequestMethod.GET)
    public void initCreationForm(HttpServletRequest request, ModelMap model) throws ParseException {

        System.out.println(request.getParameter("latlon"));

        System.out.println(SecurityUtils.getSubject().getPrincipal().toString());

        String latlon = request.getParameter("latlon");
        String[] cod = latlon.split(",");

        WKTReader reader = new WKTReader();

        impl.saveUserLocation(SecurityUtils.getSubject().getPrincipal().toString(),(Point) reader.read("POINT("+cod[0]+" "+cod[1]+")"));

        return ;
    }

}

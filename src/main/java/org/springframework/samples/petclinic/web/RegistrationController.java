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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.samples.petclinic.model.Owner;
import org.springframework.samples.petclinic.model.Pet;
import org.springframework.samples.petclinic.model.PetType;
import org.springframework.samples.petclinic.model.Users;
import org.springframework.samples.petclinic.repository.jpa.JpaUserRepositoryImpl;
import org.springframework.samples.petclinic.service.ClinicService;
import org.springframework.samples.petclinic.service.ClinicServiceImpl;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Collection;

/**
 * @author Juergen Hoeller
 * @author Ken Krebs
 * @author Arjen Poutsma
 */
@Controller
public class RegistrationController {

    @Autowired
    ClinicService impl;

    @RequestMapping(value = "/near", method = RequestMethod.GET)
    public String near(HttpServletRequest request, ModelMap model) {

        return "near";
    }

    @RequestMapping(value = "/register.do", method = RequestMethod.POST)
    public String initCreationForm(HttpServletRequest request, ModelMap model) {

        System.out.println(request.getParameter("fname"));

        Users user = new Users();

        user.setUsername(request.getParameter("uname"));
        user.setPassword(request.getParameter("pass"));

        impl.saveUser(user);

        return "register-success";
    }

}

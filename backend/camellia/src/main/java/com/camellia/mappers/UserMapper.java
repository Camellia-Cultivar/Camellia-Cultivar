package com.camellia.mappers;

import com.camellia.models.users.User;
import com.camellia.models.users.UserDTO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface UserMapper {

    UserMapper MAPPER = Mappers.getMapper(UserMapper.class );

    User userDTOtoUser(UserDTO dto);

    UserDTO userToUserDTO(User user);
}

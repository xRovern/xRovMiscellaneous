import collections
import functools
import typing


def type_check(func):
    @functools.wraps(func)
    def check(*args, **kwargs):
        for i in range(len(args)):
            var = args[i]
            var_name = list(func.__annotations__.keys())[i]
            var_type = list(func.__annotations__.values())[i]
            check_generic(var, var_name, var_type)

        result = func(*args, **kwargs)
        if "return" in func.__annotations__:
            var = result
            var_name = "return"
            var_type = func.__annotations__["return"]
            check_generic(var, var_name, var_type)
        return result

    def check_generic(var, var_name, var_type):
        if "GenericAlias" in str(type(var_type)):
            is_list = var_type.__origin__ is list
            if (
                is_list
                or var_type.__origin__ is dict
                or var_type.__origin__ is collections.Mapping
            ):
                for j, each in enumerate(var):
                    arg = each if is_list else var[each]
                    arg_name = (
                        ("arg_" + str(j) + " in list " + var_name)
                        if is_list
                        else (each + " in dict " + var_name)
                    )
                    arg_type = var_type.__args__[0] if is_list else var_type.__args__[j]
                    check_generic(arg, arg_name, arg_type)
            elif var_type.__origin__ is typing.Union:
                arg = var
                arg_name = "arg in union " + var_name
                arg_type = var_type.__args__
                if type(arg) not in arg_type:
                    error_msg = (
                        "Variable `"
                        + str(arg_name)
                        + "` is type "
                        + str(arg_type)
                        + " instead of type ("
                        + str(type(arg))
                        + ")"
                    )
                    raise TypeError(error_msg)
            else:
                raise RuntimeError("Check is not defined.")
        else:
            error_msg = (
                "Variable `"
                + str(var_name)
                + "` is type ("
                + str(var_type)
                + ") instead of type ("
                + str(type(var))
                + ")"
            )
            if not isinstance(var, type(var_type) if var_type == None else var_type):
                raise TypeError(error_msg)

    return check

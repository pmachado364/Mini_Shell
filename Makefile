NAME = minishell

SRC = main.c ./parsing/lexer.c ./parsing/expander.c ./parsing/input_parsing.c ./executer/execute_2.c ./executer/execute_red.c\
		./executer/execute.c	./parsing/input_divider.c	./executer/exe_bui.c ./parsing/expand_utils.c ./executer/execute_utils.c\
		./builtins/exit.c ./builtins/env.c ./builtins/pwd.c ./builtins/builtins_utils.c ./builtins/echo.c ./parsing/input_parsing_3.c\
		./builtins/unset.c ./builtins/export.c ./utils/utils.c ./utils/utils_2.c ./parsing/expander2.c ./parsing/expander3.c ./parsing/input_parsing_2.c\
		./builtins/cd.c	./builtins/builtins_utils2.c ./main_utils.c ./main_utils_2.c ./parsing/input_div_2.c ./executer/exe_bui_2.c ./builtins/builtins_utils3.c\

LIBS = ./libs/libft/libft.a	./libs/ft_printf/libftprintf.a

CC = cc -Wall -Werror -Wextra -g

COLOUR_GREEN = \033[0;32m

COLOUR_END = \033[0m

$(VERBOSE).SILENT:

all: $(NAME)

$(NAME): $(SRC) $(LIBS)
		@echo "$(COLOUR_GREEN)COMPILING SOURCE CODE FOR MINISHELL...$(COLOUR_END)"
		@$(CC) $(SRC) $(LIBS) -lreadline -o $(NAME)
		@echo "$(COLOUR_GREEN)SOURCE FILES SUCESSFULLY COMPILED$(COLOUR_END)"

re: fclean all

$(LIBS):
		@echo "$(COLOUR_GREEN)COMPILING NECESSESSARY LIBRARYS TO RUN MISHELL...$(COLOUR_END)"
		@make -C ./libs/libft
		@make -C ./libs/ft_printf
		@echo "$(COLOUR_GREEN)LIBRARIES SUCESSFULLY COMPILED$(COLOUR_END)"

valgrind: 
	@echo "{\n   leak readline\n   Memcheck:Leak\n...\n   fun:readline\n}\n{\n   leak add_history\n   Memcheck:Leak\n...\n   fun:add_history\n}" > readline.supp
	@valgrind --suppressions=readline.supp --leak-check=full -s --show-leak-kinds=all ./$(NAME)

clean:
		@echo "$(COLOUR_GREEN)CLEANING OBJECTS FROM LIBRARIES...$(COLOUR_END)"
		@rm	readline.supp
		@make clean -C ./libs/libft
		@make clean -C ./libs/ft_printf
		@echo "$(COLOUR_GREEN)CLEANING COMPLETED$(COLOUR_END)"
fclean:
		@echo "$(COLOUR_GREEN)CLEANING EVERYTING EXCEPT SOURCE CODE...$(COLOUR_END)"
		@make fclean -C ./libs/libft
		@make fclean -C ./libs/ft_printf
		@rm -f minishell
		@echo "$(COLOUR_GREEN)CLEANING COMPLETED$(COLOUR_END)"
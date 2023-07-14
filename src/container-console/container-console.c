/*
 * SPDX-License-Identifier: Apache-2.0
 * This file is part of termux-container.
 *
 * Copyright (c) 2023 Moe-hacker
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */
// 此文件为CONTAINER_CONSOLE函数的c语言重构
// 此文件不会随termux官方仓库更新，应被静态编译
// 如果你的代码好不容易能跑起来了，就不要动它了
// 难写的代码一定要难读
#include "container-console.h"
// container-console结束后退出，用于ctrl-c捕获
void restart(int unused)
{
  system("container-console");
  // 没太大必要，但是在这里加一下
  system("stty icanon");
  system("stty echo");
  system("stty erase '^?'");
  // 直接退出
  exit(0);
}
int main(void)
{
  if (geteuid() == 0)
  {
    fprintf(stderr, "%s\n", "\033[33mWarning: container-console should not be run with root privileges!");
  }
  // 判断termux-container是否存在
  if (system("container -t") != 0)
  {
    fprintf(stderr, "%s\n", "\033[31mError: termux-container not installed.");
    exit(1);
  }
  // 设置默认值
  // 用于获取输入
  char input = 0;
  // 第一个参数，用于语法高亮
  char arg0[1024];
  arg0[0] = '\000';
  // 第二个参数，不会高亮
  char arg1[1024];
  arg1[0] = '\000';
  // 最终调用的命令
  char command[2048];
  char *output = NULL;
  output = arg0;
  // 历史记录文件定义
  FILE *history = NULL;
  char history_file[PATH_MAX];
  char *home = getenv("HOME");
  if (!home)
  {
    fprintf(stderr, "%s\n", "\033[31mError: $HOME is not set.");
    exit(1);
  }
  strcat(history_file, home);
  strcat(history_file, "/.container_history");
  // 要读的行号
  unsigned int line_to_read = 0;
  // 最终为行数-行号(因为是正着读文件，行号却是倒数)
  unsigned int total_lines = 0;
  // 当前行号减1
  unsigned int line_now = 0;
  // 立即捕获输入，不等待回车
  system("stty -icanon");
  // 关闭输入显示
  system("stty -echo");
  // 用于删除键捕获
  system("stty erase '^h'");
  // 处理ctrl-c信号
  signal(SIGINT, restart);
  // console循环
  printf("\n\033[1;38;2;254;228;208mConsole > \033[0m");
  while (true)
  {
    // 获取一个字符
    input = (char)getchar();
    switch (input)
    {
    // EOF捕获，即ctrl-d
    case '\004':
      // 还原终端设置并退出
      system("stty erase '^?'");
      system("stty icanon");
      system("stty echo");
      printf("\n");
      exit(0);
    // 上下键捕获
    case '\033':
      // 忽略`[`符号
      getchar();
      switch (getchar())
      {
      // 上键
      case 'A':
        // 当前行号
        line_now = 0;
        for (unsigned int i = 0; i < (strlen(arg0) + strlen(arg1)); i++)
        {
          // 退格并覆盖字符显示
          printf("\b");
          printf(" ");
          printf("\b");
        }
        history = fopen(history_file, "a+e");
        // 回到文件头
        fseek(history, 0, SEEK_SET);
        arg0[0] = '\000';
        arg1[0] = '\000';
        output = arg0;
        // 统计行数
        total_lines = 0;
        for (int i = 0; (i = fgetc(history)) != EOF;)
        {
          if (i == '\n')
          {
            total_lines++;
          }
        }
        // 修复空文件读取
        if (total_lines == 0)
        {
          goto end;
        }
        // 设置要读的行号
        if (total_lines > line_to_read)
        {
          line_to_read++;
          total_lines = total_lines - line_to_read;
        }
        else
        {
          total_lines = 0;
        }
        // 回到文件头
        fseek(history, 0, SEEK_SET);
        // 逐字符读取历史文件
        while (true)
        {
          input = (char)fgetc(history);
          switch (input)
          {
          // 换行符(统计行号)
          case '\n':
            // 到达要读的行
            if (line_now == total_lines)
            {
              // 结束读取
              fclose(history);
              goto end;
            }
            else
            {
              // 行号加一
              line_now++;
              continue;
            }
            break;
          // 空格用于分割arg0和arg1
          case ' ':
            // 判断是否写入arg1
            if (line_now == total_lines)
            {
              if (arg0[0] != '\000')
              {
                // 判断是否需要切换到arg1
                if (arg1[0] == '\000')
                {
                  output = arg1;
                }
                strcat(output, &input);
              }
            }
            break;
          // 空字符，忘了干啥的了反正能跑
          case '\000':
            break;
          default:
            // 写入数据
            if (line_now == total_lines)
            {
              strcat(output, &input);
              break;
            }
          }
        }
      end:
        break;
        // 下键
      case 'B':
        // 当前行号
        line_now = 0;
        for (unsigned int i = 0; i < (strlen(arg0) + strlen(arg1)); i++)
        {
          // 退格并覆盖字符显示
          printf("\b");
          printf(" ");
          printf("\b");
        }
        if (line_to_read > 1)
        {
          line_to_read--;
        }
        else
        {
          line_to_read = 1;
        }
        history = fopen(history_file, "a+e");
        // 回到文件头
        fseek(history, 0, SEEK_SET);
        arg0[0] = '\000';
        arg1[0] = '\000';
        output = arg0;
        // 统计行数
        total_lines = 0;
        for (int i = 0; (i = fgetc(history)) != EOF;)
        {
          if (i == '\n')
          {
            total_lines++;
          }
        }
        // 修复空文件读取
        if (total_lines == 0)
        {
          goto end1;
        }
        // 设置要读的行号
        total_lines = total_lines - line_to_read;
        // 回到文件头
        fseek(history, 0, SEEK_SET);
        while (true)
        {
          input = (char)fgetc(history);
          switch (input)
          {
          // 换行符
          case '\n':
            if (line_now == total_lines)
            {
              // 结束读取
              fclose(history);
              goto end1;
            }
            else
            {
              // 行号加一
              line_now++;
              continue;
            }
            break;
          case ' ':
            // 判断是否写入arg1
            if (line_now == total_lines)
            {
              if (arg0[0] != '\000')
              {
                // 判断是否需要切换到arg1
                if (arg1[0] == '\000')
                {
                  output = arg1;
                }
                strcat(output, &input);
              }
            }
            break;
          case '\000':
            break;
          default:
            // 写入数据
            if (line_now == total_lines)
            {
              strcat(output, &input);
              break;
            }
          }
        }
      }
    end1:
      break;
    // 删除键
    case 127:
      // 判断是否写入arg1
      if (arg1[0] == '\000')
      {
        if (strlen(output) > 0)
        {
          // 删除一个字符
          output[strlen(output) - 1] = '\000';
          // 退格并覆盖字符显示
          printf("\b");
          printf(" ");
          printf("\b");
        }
      }
      else
      {
        // 判断是否切换到arg0
        if (strlen(output) > 0)
        {
          // 删除一个字符
          output[strlen(output) - 1] = '\000';
          // 退格并覆盖字符显示
          printf("\b");
          printf(" ");
          printf("\b");
        }
        else
        {
          output = arg0;
          // 删除一个字符
          output[strlen(output) - 1] = '\000';
          // 退格并覆盖字符显示
          printf("\b");
          printf(" ");
          printf("\b");
        }
      }
      break;
    // 回车
    case '\n':
      // exit命令执行
      if (strcmp(arg0, "exit") == 0)
      {
        // 还原终端设置并退出
        system("stty erase '^?'");
        system("stty icanon");
        system("stty echo");
        printf("\n");
        exit(0);
      }
      // 合成最终执行命令
      strcat(command, "container -e CONTAINER_CONSOLE_MAIN ");
      strcat(command, arg0);
      strcat(command, arg1);
      printf("\n");
      // 执行命令
      system(command);
      // 写入记录
      history = fopen(history_file, "a+e");
      fprintf(history, "%s%s%s", arg0, arg1, "\n");
      fclose(history);
      // 恢复默认值
      arg0[0] = '\000';
      arg1[0] = '\000';
      command[0] = '\000';
      line_to_read = 0;
      output = arg0;
      printf("\033[1;38;2;254;228;208mConsole > \033[0m");
      break;
    // 空格
    case ' ':
      // 删除行首空格
      if (arg0[0] != '\000')
      {
        // 判断是否需要切换到arg1
        if (arg1[0] == '\000')
        {
          output = arg1;
          strcat(output, &input);
        }
        else
        {
          strcat(output, &input);
        }
      }
      break;
    // 其他字符输入
    default:
      strcat(output, &input);
      break;
    }
    // 内置语法高亮，不考虑扩展性故直接用最简单的写法
    if (strcmp(arg0, "help") == 0 || strcmp(arg0, "exit") == 0 || strcmp(arg0, "new") == 0 || strcmp(arg0, "search") == 0 || strcmp(arg0, "pull") == 0 || strcmp(arg0, "rmi") == 0 || strcmp(arg0, "cp") == 0 || strcmp(arg0, "ls") == 0 || strcmp(arg0, "rm") == 0 || strcmp(arg0, "login") == 0 || strcmp(arg0, "import") == 0 || strcmp(arg0, "export") == 0 || strcmp(arg0, "info") == 0)
    {
      printf("\033[11G\033[1;38;2;166;227;161m%s\033[0m%s", arg0, arg1);
    }
    else
    {
      printf("\033[11G%s%s", arg0, arg1);
    }
  }
  return 0;
}

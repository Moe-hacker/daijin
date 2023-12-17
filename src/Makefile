# SPDX-License-Identifier: Apache-2.0
#
# This file is part of termux-container, with ABSOLUTELY NO WARRANTY.
#
# Copyright (c) 2021-2023 Moe-hacker
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
all :
	[ -e nekoasc/nekoasc ]||(cd nekoasc&&make static-bionic)
	[ -e ruri/ruri ]||(cd ruri&&make static-bionic)
	[ -e yoshinon/yoshinon ]||(cd yoshinon&&make)
	[ -e container-console/container-console ]||(cd container-console&&make)
format :
	shfmt -i 2 -w container
	shfmt -i 2 -w ../share/shell/*
update :
	cd nekoasc&&git pull git@github.com:moe-hacker/nekoasc main
	cd rootfstool&&git pull git@github.com:moe-hacker/rootfstool main
	cd ruri&&git pull git@github.com:moe-hacker/ruri main
	cd yoshinon&&git pull git@github.com:moe-hacker/yoshinon main
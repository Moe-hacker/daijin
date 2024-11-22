# Copyright 2024 moe-hacker
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
all: build
# Just call build.sh.
build:
	./build.sh
# Format script.
format:
	shfmt -i 2 -w src/share/*.sh
	shfmt -i 2 -w *.sh
	shfmt -i 2 -w src/daijin
# Update submodule.
update:
	cd src/rootfstool&&git pull git@github.com:moe-hacker/rootfstool main
	cd src/yoshinon&&git pull git@github.com:moe-hacker/yoshinon main
	cd src/rurima&&git pull git@github.com:moe-hacker/rurima main

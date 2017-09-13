# This is the first unrefactored cookbook and will be broken out later as I learn more

## To test this cookbook with test kitchen:
1. Have a copy of ChefDK or Chef and InSpec
2. Have a copy of Vagrant and VirtualBox installed
3. Run `berks install`
4. Run `kitchen test`

## To test this cookbook with ChefSpec:
1. Have a copy of ChefDK or Chef and ChefSpec
2. Run `berks install`
3. Run `chef exec rspec -f d`

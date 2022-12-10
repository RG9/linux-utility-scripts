##############################################################################################################
# Print all my commits in format "year.month | commit message" from last 6 months. Ignores cleanups and tests.
# Use case: Recall what I was doing ;)
# Example: ./{script-name} 
##############################################################################################################

git log --author $(git config user.email) --pretty=format:"%ad %s" --date=format:"%y.%m | " --since=6.months | grep -viE "cleanup|test" | sort
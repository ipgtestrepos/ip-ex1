# ip-ex1

This repository is for testing purposes of an indexing system only.  There is no implied or inferred
functionality.

# Organization

Revisions on the data is controlled by tags.   For each tagged version of the repository, you can
run the loading script which will load versioned data for each.  Do a git tag to see which versions
are available.

# Example

% git tag list
  v1.0
  v2.0

% git tag checkout v1.0
% ./openhw_products.sh
% git tag checkout v2.0
% ./openhw_products.sh







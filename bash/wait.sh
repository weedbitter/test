#!/bin/bash
#
#rker name cnt
#
worker () {
	   i=0;
	      while [ $i -lt $2 ]; do
	             echo "[$@] start";
			         ((i=i+1));
			         echo "[$@] sleep";
					        sleep 3;
							   done
							      echo "[$@] completed";
							  }

							  worker 'A' 1 &
							  worker 'B' 2 &
							  worker 'C' 3 &
							  worker 'D' 4 &

							  wait
							  echo "all completed";
